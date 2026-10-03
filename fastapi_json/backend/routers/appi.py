from fastapi import FastAPI, HTTPException, status,APIRouter
from schemas.question import Questionrequest, Answerresponse
from services.answerlogic import find_answer

app = FastAPI()
router = APIRouter()

@router.post("/ask", response_model=Answerresponse, status_code=status.HTTP_200_OK)
def ask_question(question: Questionrequest):
    """
    Endpoint to ask a question.
    
    Args:
        question (QuestionBase): The question data.
        
    Returns:
        QuestionBase: The created question.
    """
    #answer = find_answer(question.question)  # Call the function to find the answer
    # Here you would typically save the question to a database or perform other logic
    try:
        answer = find_answer(question.question)

        return Answerresponse(answer=answer)

    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )