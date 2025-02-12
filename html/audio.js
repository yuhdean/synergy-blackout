let soundPlaying = false;

window.addEventListener('message', function (event) {
    if (event.data.action === 'playSound') {
        playAudio(event.data.sound);
    }
});

function playAudio(sound) {
    if (soundPlaying) return;  

    let audio = new Audio('sounds/' + sound + '.mp3');
    audio.play();
    soundPlaying = true;

    audio.onended = function () {
        soundPlaying = false;
    };
}
