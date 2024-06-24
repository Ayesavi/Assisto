import { ChatOpenAI, ChatOpenAICallOptions } from "@langchain/openai";

class CreateAssistUsingAI {
  private model: ChatOpenAI<ChatOpenAICallOptions>;
  private schema: object = {
    title: "ResponseModel",
    description: "Response model for a created assist",
    type: "object",
    properties: {
      tags: {
        title: "Tags",
        description:
          "A list of suitable tags for the assist. There must be a minimum of 5 tags.",
        type: "array",
        items: {
          type: "string",
        },
        minItems: 5,
      },
      title: {
        title: "Title",
        description: "The title of the assist.",
        type: "string",
      },
      description: {
        title: "Description",
        description:
          "A brief explanation of the assist, detailing all relevant information.",
        type: "string",
      },
      deadline: {
        title: "Deadline",
        description:
          "The deadline by which the assist must be completed, in ISO 8601 format.",
        type: "string",
      },
      budget: {
        title: "Budget",
        description:
          "The maximum amount the user is willing to pay for the assistance.",
        type: "integer",
      },
      ageGroup: {
        title: "Age Group",
        description:
          "The age group eligible to assist, represented by two numbers separated by a dash (e.g., 25-30).",
      },
      gender: {
        title: "Gender",
        description:
          "The gender of the person who can assist. Possible values are 'male' or 'female'.",
        type: "string",
        enum: ["male", "female"],
      },
    },
    required: ["tags", "title", "description"],
  };

  constructor() {
    this.model = new ChatOpenAI({
      openAIApiKey: process.env.OPENAI_API_KEY,
    });
  }

  async call(context: string) {
    try {
      const runnable = this.model.withStructuredOutput(this.schema, {});
      let data = await runnable.invoke(context);
      return data;
    } catch (error) {
      console.log(error);
      return;
    }
  }
}

export default CreateAssistUsingAI;
