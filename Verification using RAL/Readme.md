<h2>About</h2>
This project is the verification of an RTL design having multiple registers each having having their own different fields and configurations using Register Abstraction Layer (RAL).
UVM RAL is an object-oriented model for registers inside the DUT. It provides built-in base classes and APIs which eases the effort required for accessing the registers.
RAL model consists of desired and mirrored values where desired value is the value that has to be programmed to DUT while mirrored value captures DUT register values and can be modified during runtime.<br>
<br><h3> Advantages of RAL - </h3> 
<ul>
<li> Support for various register attributes like R/W,RO,WO,W1C etc.
<li> Provides high level abstraction for reading and writing DUT registers.
<li> Same model can be accessed by multiple buses.
<li> Supports both frontdoor and backdoor access.
<li> Enhances uniformity and reusability.
</ul>
<h3> Components - </h3>
<ul>
<li> RTL folder consists of the DUT written in System Verilog. 
<li> ENV folder contains all the components of layered testbench having both register files and environment components.
<li> SIM folder consists of makefile, do file, waveform file and transcript.
<li> TEST folder consists of testcase and package file.
<li> TOP folder consists of top file which contains DUT, interfaces and testcase. 
</ul><br>
<h2>Verification Architecture</h2>
<img src="https://github.com/AlPrime2k1/UVM/blob/main/Verification%20using%20RAL/ARCH.JPG">
</br>
Although this is not the exact architecture used in the project, it is the generic structure for Verification using RAL model.<p>
As shown in the figure, the registers under reg_file are different registers present in the design. In this project, we have four registers namely - Status, Control, IO and Mem.<br>
Address map consists of base address as 'h400 while offset value varies for each register. The address of each register is given by adding base address and offset value.<br>
Adapter consists of methods for conversion of bus item to reg item and vice versa. More information on adpater is provided in its source code.<br>
Environment consists of reg_model, agent, adapter and predictor.
<h2>How to use</h2>
<ol>
  <li> Download the folder Verification using RAL.
  <li> Open the SIM folder and type cmd in the address bar. Alternatively open cmd and go inside the SIM folder of this directory.
  <li> In cmd, type vlib work to create directory for Questa. Only needed to do it once, although this step can be skipped as it is included in makefile.
  <li> Makefile info : <ul>
    <li> Type make or make cmd to compile and simulate in command prompt.
    <li> Type make gui to compile and simulate in QuestaSIM gui.
    <li> Type make log to compile.
    <li> Type make sim to simulate.
    </ul>
  <li> Go to ENV/register_files/reg_base_seq_lib.sv to see the various methods invoked in the sequence. Here are some of the RAL methods - <img src = "https://github.com/AlPrime2k1/UVM/blob/main/Verification%20using%20RAL/API.JPG">
    </ol>
 
<footer>
  For more information, contact me here<br>
  <a href="mailto:kirti.kumar2k1@gmail.com">E-mail</a></p>
</footer>
