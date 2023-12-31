class LeavesController < ApplicationController
  before_action :set_employee
  before_action :set_leave, only: [:show, :update, :destroy]

  def index
    leaves = @employee.leaves
    render json: leaves, each_serializer: LeaveSerializer
  end

  def show
    render json: @leave, each_serializer: LeaveSerializer
  end

  def create
    leave = @employee.leaves.new(leave_params)
    if leave.save
      render json: leave, status: :created
    else
      render json: leave.errors.messages, status: :unprocessable_entity
    end
  end
  
  def update 
    if @leave.update(leave_params)
      render json:@leave
    else
      render json: @leave.errors.messages
    end
  end

  def destroy
    @leave.destroy
  end
  
  def applied_leaves
    leaves = Leave.where(mail_to: @employee.email)
    render json: leaves 
  end 

  def approve_leaves
    leave = Leave.find_by(mail_to: @employee.email ,id:params[:id])
    if leave
      if leave.update(status: params[:status], to_date: params[:to_date],from_date: params[:from_date])
        days = leave.accepted_leaves
        render json:leave
      else
        render json: leave.errors.messages
      end
    end
  end

  private

  def leave_params
    params.require(:leave).permit(:leave_type, :from_date, :to_date, :days, :mail_to, :reason, :from_session, :to_session)
  end

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_leave
    @leave = @employee.leaves.find(params[:id])
  end 
end
