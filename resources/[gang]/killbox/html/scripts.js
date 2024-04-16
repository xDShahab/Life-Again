$(function () {
    var sound = new Audio('sound.mp3');
    sound.volume = 0.8;
    window.addEventListener('message', function (event) {
        if (event.data.action == 'open') {
            var number = Math.floor((Math.random() * 500) + 1);
            $('.toast').append(`
            <div class="wrapper-${number}">
                <div class="notification_main-${number}">
                    <div class="title-${number}"></div>
                    <div class="text-${number}">
                        ${event.data.message}
                    </div>
                </div>
            </div>`)

            $(`.wrapper-${number}`).css({
                "margin-bottom": "10px",
                "width": "275px",
                "margin": "0 0 8px -180px",
                "border-radius": "10px"
            })

            $('.notification_main-'+number).addClass('main')

            $('.text-'+number).css({
                "font-size": "14px"
            })

            if (event.data.type == 'Kill') {

                $(`.notification_main-${number}`).addClass('kill-icon')
                $(`.wrapper-${number}`).addClass('Kill Kill-border')
                

            } else if (event.data.type == 'error') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "10px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('error-icon')
                $(`.wrapper-${number}`).addClass('error error-border')
               
            }
            anime({
                targets: `.wrapper-${number}`,
                translateX: -50,
                duration: 750,
                easing: 'spring(1, 70, 100, 10)',
            })
            setTimeout(function () {
                anime({
                    targets: `.wrapper-${number}`,
                    translateX: 950,
                    duration: 950,
                    easing: 'spring(1, 180, 100, 0)'
                })
                setTimeout(function () {
                    $(`.wrapper-${number}`).remove()
                }, 950)
            }, event.data.time)
        }
    })
})