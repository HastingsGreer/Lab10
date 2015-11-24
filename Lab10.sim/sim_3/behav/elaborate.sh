#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 602e4366ef7c4cb2b915373ada5c43b8 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot topsim_behav xil_defaultlib.topsim xil_defaultlib.glbl -log elaborate.log
