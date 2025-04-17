class Admin::MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  
  def index
    @members = Member.ordered_by_name
    @members = @members.active if params[:active_only] == "true"
    @members = @members.inactive if params[:inactive_only] == "true"
  end
  
  def show
  end
  
  def new
    @member = Member.new
  end
  
  def create
    @member = Member.new(member_params)
    
    if @member.save
      redirect_to admin_member_path(@member), notice: "Member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @member.update(member_params)
      redirect_to admin_member_path(@member), notice: "Member was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @member.destroy
    redirect_to admin_members_path, notice: "Member was successfully deleted."
  end
  
  private
  
  def set_member
    @member = Member.find(params[:id])
  end
  
  def member_params
    params.require(:member).permit(
      :first_name, :last_name, :email, :phone, :date_of_birth,
      :address, :city, :state, :postal_code, :rank, :join_date,
      :active, :notes
    )
  end
end 