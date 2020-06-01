# HW 3 CMLS - VOICE HARMONIZER
Implementation of a voice harmonizer using [SuperCollider](https://supercollider.github.io/) and [Processing 3](https://processing.org/).
From the mic input 2 more voices are added (3rd and 5th of the selected chord) and some effect can be applied.

Two types of modality:
- **Individual**: all the parameters are available in one window.
- **Collaborative**: more people can collaborate and play together by choosing which parameter they want to control.

Harmonization chords:
- **Major**
- **Minor**
- **Augmented**
- **Diminished**

Effects:
- **Reverb**: Dry/wet ratio and Room size can be modified through 2D Pads.
- **Delay**: Wet gain and Time can be modified through 2D Pads.

More detailed information can be found on `Group 18 - Homework 3 Report.pdf`.

## Individual mode

Run the supercollider code first and then the Processing script.

## Collaborative mode

In order to run the collaborative mode

download [https://securesocketfunneling.github.io/ssf](https://securesocketfunneling.github.io/ssf)

and run
```./ssf -V 0.0.0.0:57120:127.0.0.1:57120 -p 10000 wavein.ch```
the ssfd server should be up and running on wavein.ch, if it's not the case contact @minettiandrea