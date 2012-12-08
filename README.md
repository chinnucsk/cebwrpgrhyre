PE-solutions
============

Solutions to problems from a website named after a fameous mathemetican (name 
not mentioned because of google).
All solutions to this date are written in Erlang and are invoked using escript. 
Most problems solve fairly quickly but sometimes an increase in speed can be 
gained by using the -n flag, forcing native compilation of the code.

Installation Instructions
=========================

1, Install Erlang/Otp for the platorm that you are currently on. Binaries can be 
downloaded from erlang.org for Win/Linux/Mac. You should also install git but
since you are here you have probably done that already.

2, Clone this repo to your harddrive from the prompt:
git clone https://github.com/R4zzM/pe-solutions.git

3, Compile the library, at the prompt type:
./rebar compile

4, This is optional but you can make sure that everything is in order by 
running the tests. At the prompt type:
./rebar eunit

4, Go into the escript folder and run any of the scripts. The answer should be
printed to the prompt.

Misc
====
Yes, it's total overkill to use rebar here since there is only one source file 
the need to be compiled but I wanted to learn how it worked. :p