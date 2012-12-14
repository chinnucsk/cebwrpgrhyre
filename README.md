PE-solutions
============
Solutions to problems from cebwrpgrhyre.arg (rot13 due to goolge).
All solutions to this date are written in Erlang and are invoked using escript. 
Most problems solve fairly quickly but sometimes an increase in speed can be 
gained by using the -n flag, forcing native compilation of the code.

<b>Installation Instructions</b>
1, Install Erlang/Otp for the platorm that you are currently on. Binaries can be 
downloaded from erlang.org for Win/Linux/Mac. You must also install git but
since you are here you have probably done that already.<br/>

2, Clone the repo:<br/>
<code>git clone https://github.com/R4zzM/pe-solutions.git</code>

3, Compile the library:<br/>
<code>./rebar compile</code>

4, This is optional but you can make sure that everything is in order by 
running the tests:<br/>
<code>./rebar eunit</code>

5, Go into the escript folder and run any of the scripts. The answer should be
printed to the prompt.

<b>Misc</b>
Yes, it's total overkill to use rebar here since there is only one source file 
the need to be compiled but I wanted to learn how it worked...