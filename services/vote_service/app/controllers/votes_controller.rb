class VotesController < ApplicationController
  
  # /api/v1/votes/entries/:entry_id/users/:user_id
  def create
    begin
      json = Yajl::Parser.create(request.body.read)
      
      vote = Vote.create_or_update(
        :user_id => params[:user_id],
        :entry_id => params[:entry_id],
        :value => json["value"]
      )
      if vote.valid?
        render :json => vote.to_json
      else
        render :json => vote.errors.to_json, :status => 400
      end
    rescue => e
      render :json => e.message.to_json, :status => 500
    end
  end
  
  # GET /api/v1/votes/users/:user_id/up
  def entry_ids_voted_up_for_user
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 25).to_i
    user_id = params[:user_id].to_i
    count = Vote.up.user_id(user_id).count
    entry_ids = Vote.voted_up_for_user_id(user_id, page, per_page)
    data = {
      :total => count,
      :entries => entry_ids
    }
    data[:previous_page] = user_up_votes_url(
      :user_id => user_id,
      :page => page - 1
      :per_page => per_page
    ) if page > 1
    data[:next_page] = user_up_votes_url(
    :user_id => user_id,
    :page => page + 1,
    :per_page => per_page
    ) if (page*per_page) < count
    render :json => data.to_json
  end
  
  def entry_ids_voted_down_for_user
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 25).to_i
    user_id = params[:user_id].to_i
    count = Vote.down.user_id(user_id).count
    entry_ids = Vote.voted_down_for_user_id(user_id, page, per_page)
    data = {
      :total => count,
      :entries => entry_ids
    }
    data[:previous_page] = user_down_votes_url(
      :user_id => user_id,
      :page => page - 1
      :per_page => per_page
    ) if page > 1
    data[:next_page] = user_down_votes_url(
    :user_id => user_id,
    :page => page + 1,
    :per_page => per_page
    ) if (page*per_page) < count
    
    render :json => data.to_json
  end
  
  # GET /api/v1/votes/entries/totals?id=1,2
  def totals_for_entries
    entry_ids = params[:ids].split(",")
    data = entry_ids.inject({}) do |result, entry_id|
      result.merge!(entry_id => {
        :up => Vote.up.entry_id(entry_id).count,
        :down => Vote.down.entry_id(entry_id).count
      })
    end
    render :json => data.to_json
  end
  
  # GET /api/v1/votes/users/:user_id
  def votes_for_users
    user_id = params[:user_id]
    entry_ids = params[:ids].split(',')
    data = entry_ids.inject({}) do |result, entry_id|
      vote = Vote.find_by_user_id_and_entry_id(user_id, entry_id)
      if vote
        result.merge!(entry_id => vote.value)
      else
        result
      end
    end
    render :json => data.to_json
  end
  
  # GET /api/v1/votes/users/:user_id/totals
  def totals_for_user
    user_id = params[:user_id]
    data = {
      :up => Vote.up.user_id(user_id).count,
      :down => Vote.down.user_id(user_id).count
    }
    render :json => data.to_json
  end
end
