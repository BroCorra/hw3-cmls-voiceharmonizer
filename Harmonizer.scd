s.boot;

(
SynthDef(\harmonizer,
	{
		arg bus, first_interval=4, second_interval=7, first_gain=0.5, second_gain=0.5;
		var s_in, s_out, pr1, pr2, first_voice, second_voice;

		//Calculate pitch shift ratios for the 2 voices
		pr1 = 2**(first_interval/12);
		pr2 = 2**(second_interval/12);

		//Take the input from soundcard
		s_in = SoundIn.ar(0);

		//Compute first voice
		first_voice = PitchShift.ar(in:s_in, pitchRatio:pr1, mul:first_gain);
		//Compute second voice
		second_voice = PitchShift.ar(in:s_in, pitchRatio:pr2, mul:second_gain);
		//Compute the harmonized signal
		s_out = s_in + first_voice + second_voice;

		//Write output to the bus
		Out.ar(bus, s_out);
	}
).add;

SynthDef(\delay,
	{
		arg bus, d_wet=0.5, d_time=0.5;
		var s_in, s_out;

		//Read the input signal from the bus
		s_in = In.ar(bus);

		//Compute the output signal (as original + delayed)
		s_out = s_in + CombC.ar(in:s_in, maxdelaytime:1, delaytime:d_time, decaytime:5, mul:d_wet);

		//Write output on the bus
		Out.ar(bus, s_out);
	}
).add;

SynthDef(\reverb,
	{
		arg bus, r_mix=0.5, r_room=0.5;
		var s_in, s_out;

		//Read input signal from the bus
		s_in = In.ar(bus);

		//Compute output signal
		s_out = FreeVerb.ar(in:s_in, mix:r_mix, room:r_room, damp:0.8);

		//Output the signal
		Out.ar([0, 1], s_out);
	}
).add;

b = Bus.audio(s);
)

NetAddr("127.0.0.1", 57120);

(
~harm = Synth.new(\harmonizer, [\bus, b]);
~del = Synth.after(~harm, \delay, [\bus, b]);
~rev = Synth.after(~del, \reverb, [\bus, b]);
)

(
f = {
	arg msg;

	var oscMsg = msg[0];

	if(msg[0] == '/harmony') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~harm.set(\first_gain, x,\second_gain, y);
	} {if(msg[0] == '/reverb') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~rev.set(\r_mix, x,\r_room, y);
	} {if(msg[0] == '/delay') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~del.set(\d_wet, x,\d_time, y);
	} {if(msg[0] == '/chord') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~harm.set(\first_interval, x,\second_interval, y);
	}}}}
};

thisProcess.addOSCRecvFunc(f);
)


thisProcess.removeOSCRecvFunc(f);

