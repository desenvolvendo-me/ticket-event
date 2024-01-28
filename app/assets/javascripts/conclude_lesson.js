document.addEventListener('DOMContentLoaded', function(){
    const concludeLessonLink = document.getElementById('conclude_lesson');

    concludeLessonLink.addEventListener('click', function (event){
        event.preventDefault();

        const slug_event = concludeLessonLink.dataset.slugEvent;
        const eventId = concludeLessonLink.dataset.eventId;
        const lessonId = concludeLessonLink.dataset.lessonId;
        const studentId = concludeLessonLink.dataset.studentId;

        var boxDialog = confirm('Deseja realmente finalizar a aula?\n Uma vez feita essa ação não poderá ser desfeita');

        if (boxDialog) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', lessonId, true);

            const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
            xhr.setRequestHeader('X-CSRF-Token', csrfToken);

            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
            xhr.onload = function (){
                if(xhr.status === 200) {
                    alert("Aula finalizada com sucesso!");
                    window.location.reload();
                } else {
                    console.error("Erro ao gravar dados no servidor.");
                }
            };
            xhr.send('slug_event=' + encodeURI(slug_event) + '&lesson_id=' + encodeURI(lessonId) + '&event_id=' + encodeURI(eventId) + '&student_id=' + encodeURI(studentId));
        } else {
            console.log("Tudo bem, poderá fazer isso mais tarde");
        }
    });
});