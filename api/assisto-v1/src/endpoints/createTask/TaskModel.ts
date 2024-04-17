

// Define interface for TaskModel initialization
interface TaskModelParams {
  ownerId: string;
  attachedLocation?: { lat: number; lng: number } | null;
  relevantTags: string[];
  taskDeadline?: Date | null;
  title: string;
  description: string;
  gender?: "female" | "other" | "male" | "any" | null;
  age?: number | null;
  expectedPrice?: number | null;
  status: "unassigned" | "paid" | "assigned" | "completed";
  id: string;
  assigned?: string | null;
  createdAt: Date;
}

// Define the TaskModel class
class TaskModel {
  ownerId: string;
  attachedLocation?: { lat: number; lng: number } | null;
  relevantTags: string[];
  taskDeadline?: Date | null;
  title: string;
  description: string;
  gender?: "female" | "other" | "male" | "any" | null;
  age?: number | null;
  expectedPrice?: number | null;
  status: "unassigned" | "paid" | "assigned" | "completed";
  id: string;
  assigned?: string | null;
  createdAt: Date;

  constructor(params: TaskModelParams) {
    this.ownerId = params.ownerId;
    this.attachedLocation = params.attachedLocation;
    this.relevantTags = params.relevantTags;
    this.taskDeadline = params.taskDeadline;
    this.title = params.title;
    this.description = params.description;
    this.gender = params.gender;
    this.age = params.age;
    this.expectedPrice = params.expectedPrice;
    this.status = params.status;
    this.id = params.id || ""; // Default value for id
    this.assigned = params.assigned;
    this.createdAt = params.createdAt;
  }

  // Method to convert TaskModel instance to JSON object (map)
  toJSONMap(): Record<string, any> {
    return {
      ownerId: this.ownerId,
      attachedLocation: this.attachedLocation,
      relevantTags : this.relevantTags,
      taskDeadline: this.taskDeadline ? this.taskDeadline.toISOString() : null,
      title: this.title,
      description: this.description,
      gender: this.gender,
      age: this.age,
      expectedPrice: this.expectedPrice,
      status: this.status,
      id: this.id,
      assigned: this.assigned,
      createdAt: this.createdAt.toISOString()
    };
  }
}

// Export the classes and enums
export default TaskModel;
