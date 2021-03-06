class DoctorsController < ApplicationController
  before_action :logged_in_doctor, only: [:index, :edit, :update, :destroy]
  before_action :correct_doctor,   only: [:edit, :update,]
  

  def index
    #  break all doctors into pages with 30 doctors per page
    @doctors = Doctor.paginate(page: params[:page])
  end
  
  
  # display doctor info
  def show
    # using .decorate (Decorate design pattern) to put fname & lname into a full name
    @doctor = Doctor.find(params[:id]).decorate
  end
  
  # create a new doctor
  def new
    @doctor = Doctor.new
  end
  
  # take the edit form input variables of the doctor id and check that the parmaters are a match with the databases
  def create
    @doctor = Doctor.new(doctor_params)
  # If the doctor is successfully created, log them in and take them their profile
    if @doctor.save
      log_in @doctor
      flash[:success] = "Welcome to Irish Smart Health Care"
      redirect_to @doctor 
    else
  # else take them to the lgoin page
      render 'new'
    end
  end
  
  # change the details of the doctor id
  def edit 
    @doctor = Doctor.find(params[:id])
  end
  
  # update the database with the editted details
  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(doctor_params)
      flash[:success] = "Profile updated"
      redirect_to @doctor
    else
      render 'edit'
    end
  end
  
  # Delete the doctor
  def destroy
    Doctor.find(params[:id]).destroy
    flash[:success] = "Doctor deleted"
    redirect_to doctors_url
  end
  
  # set paramaters to appointments dtatbase
  private
    def doctor_params
      params.require(:doctor).permit(:fname, :lname, :email, :password, :password_confirmation)
    end
    
    # Confirms a logged-in user.
    def logged_in_doctor
      unless logged_in?
      store_location
        flash[:danger] = "Please Sign In."
        redirect_to login_url
      end
    end
    
    # Confirms that the current user is a doctor and lets them to proceed
    def correct_doctor
      @doctor = Doctor.find(params[:id])
      redirect_to(root_url) unless current_doctor?(@doctor)
    end
end
    