class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy toggle_completion ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    if params[:sort] == 'desc'
      @tasks = Task.order(status: :desc)
    else 
      @tasks = Task.order(:status)
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  def toggle_completion
    @task.update(is_completed: !@task.is_completed)
    redirect_to tasks_path
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @categories = Category.all
  end

  # GET /tasks/1/edit
  def edit
    @categories = Category.all
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :category_id, :is_completed, :status)
    end
end
