import { ChatOpenAI, ChatOpenAICallOptions } from "@langchain/openai";

class CreateAssistUsingAI {
  private model: ChatOpenAI<ChatOpenAICallOptions>;
  private schema: object = {
    title: "ResponseModel",
    description: "Response model for created  assist",
    type: "object",
    properties: {
      tags: {
        title: "tags",
        description:
          "The list of suitable tags for the assist, there must be minimum 5 tags",
        type: "array",
        items: {
          type: "string",
        },
      },
      title: {
        title: "title",
        description: "The title of the assist",
        type: "string",
      },
      description: {
        title: "description",
        description:
          "The description of the assist explaining the assist briefly and explaining all info.",
        type: "string",
      },
      deadline: {
        title: "deadline",
        description:
          "The deadline, until when the assist has to be finished or done anyhow. it is an isostring of the date and time.",
        type: "string",
      },
      budget: {
        title: "budget",
        description:
          "The maximum amount the user who created the assist can pay for the assistance if somebody assists him.",
        type: "integer",
      },
    },
    required: ["tags", "title", "description"],
  };
  constructor() {
    this.model = new ChatOpenAI({ openAIApiKey: process.env.OPENAI_API_KEY });
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
