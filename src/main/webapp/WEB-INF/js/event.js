const questions = document.querySelectorAll('.question');
const answers = document.querySelectorAll('.answer');

questions.forEach((question, index) => {
    question.addEventListener('click', () => {
        // Đóng tất cả câu trả lời
        answers.forEach((answer, i) => {
            if (i !== index) {
                answer.style.display = 'none';
            }
        });

        // Mở hoặc đóng câu trả lời tương ứng
        if (answers[index].style.display === 'block') {
            answers[index].style.display = 'none';
        } else {
            answers[index].style.display = 'block';
        }
    });
});
