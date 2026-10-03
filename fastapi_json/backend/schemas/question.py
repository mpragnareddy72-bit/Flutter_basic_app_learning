from pydantic import BaseModel, Field

class Questionrequest(BaseModel):
    question: str = Field(..., description="The text of the question")

class Answerresponse(BaseModel):
    answer: str = Field(..., description="The text of the answer")
    