#!/bin/bash

WD='/home/paul/repositories/hacking/owtf/'
CMD="docker run -it -p 8009:8009 -p 8008:8008 -p 8010:8010 -v ""$WD"":/owtf owtf/owtf /bin/bash"

# execute in own bash instance
# this prevents the virtualenv
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------
