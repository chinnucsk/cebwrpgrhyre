-module (eulerlib).

-export ([execution_time/2]).

execution_time_sec({StartMSec, StartSec, _}, {EndMSec, EndSec, _}) ->
	(EndMSec - StartMSec) + (EndSec - StartMSec). 

