class InvitationsController < ApplicationController
  # POST /invitations
  # POST /invitations.json
  def create
    ivs = []
    invitee = User.find(params[:user_id])

    params[:invitations].each do |i|
      invitation = Invitation.new({ :invitee_name => invitee.name, :phone_number => format_phone(i), :user_id => params[:user_id] })
      invitation.delay.send_invite if invitation.save
      ivs << invitation
    end

    respond_to do |format|
      format.json { render json: ivs.as_json }
    end
  end
end
