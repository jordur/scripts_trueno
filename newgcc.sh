export CC=/home/ibv/jdurban/programas/gcc6.2/bin/gcc6
export CXX=/home/ibv/jdurban/programas/gcc6.2/bin/g++6
export LIBRARY_PATH=/home/ibv/jdurban/programas/gcc6.2/lib64:$LIBRARY_PATH
cd /home/ibv/jdurban/programas/Porechop
source ~/programas/virtualenv/myVE_3/bin/activate
python setup.py install
