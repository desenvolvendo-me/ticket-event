document.addEventListener('DOMContentLoaded', function(){
    const endClassLink = document.getElementById('endClass');

    if (endClassLink) {
        endClassLink.addEventListener('click', function(event){
            event.preventDefault();

            const eventId = endClassLink.dataset.eventId;
            const lessonId = endClassLink.dataset.lessonId;
            const studentId = endClassLink.dataset.studentId;
            const slugEvent = endClassLink.dataset.slugEvent;

            const questionConfirm = confirm("Deseja finalizar a aula? Uma vez finalizada não poderá ser vista novamente, deverá encaminhar uma nova solicitação de aula novamente!");

            if (questionConfirm) {
                fetch(slugEvent + '/lessons/' + lessonId, {
                    method: 'PATCH',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({
                        eventId,
                        lessonId,
                        studentId,
                        slugEvent
                    })
                })
                    .then( response => response.json())
                    .then( data => {
                        alert(data.message);
                    })
                    .catch( error => {
                        console.error("Erro ao enviar a solicitação: ", error);
                    });
            }
        });
    }
});