s.boot;

h_2 = 2; // harmonics multiples (calculate as notes) TODO
h_3 = 4;
h_4 = 6;

// reimplement usung SynthDef method TODO

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_2,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_3,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_4,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))



// add reverb TODO

// interpolate output TODO

s.kill;