#!/bin/bash
#intellize our variabels
_Path=$1
_Program=$2
#intellize the Path 
cd $1
#Checking if The Folder Contain's Makefile if not Print Out to screen "There's no such File called Makefile"
#and if we have the makefile we run it.
if [ -f "Makefile" ]; then
 make &> /dev/null 
 
_Comp=$?
#Checking 
 if [[ $_Comp == 0 ]]; then
	
  _Ans0="Pass"
	
  valgrind --leak-check=full --error-exitcode=1 ./$_Program &> /dev/null 
	
  _Valgrind_RES=$?
	
  valgrind --tool=helgrind --error-exitcode=1 ./$_Program &> /dev/null 
	
  _Helgrind_RES=$?

   if [[ $_Valgrind_RES == 0 ]]; then
    
	_Ans1="Pass"
else
	 _Ans1="Failed"
   fi

   if [[ $_Helgrind_RES == 0 ]]; then
	
    _Ans2="Pass"	

   else 
	_Ans2="Failed"
   fi

  _S=$((4*$_Comp+2*$_Valgrind_RES+1*$_Helgrind_RES))
	
  	echo "BasicCheck.sh <$_Path> <$_Program> Compilation   Memory leaks   Thread Race 
	                                      $_Ans0   ,   $_Ans1  ,      $_Ans2 "         
     
  exit $_S

 else 
	echo "The Compilation Failed"
	
 	 _Ans0="Failed"
	
	echo "BasicCheck.sh <$_Path> <$_Program> Compilation   Memory leaks   Thread Race 
	                                      $_Ans0   ,   $_Ans1  ,       $_Ans2"
   
  exit 7
	
 fi

else 
	echo "There's no such File called Makefile"
fi
