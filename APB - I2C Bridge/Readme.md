<h1>APB to I2C Bridge</h1>
<h2>About</h2>
The design RTL provided in this project is different that how normal bridges operate. This bridge operation consists of both components as slaves, so we have an APB slave and an I2C slave.
Here APB slave can do read and write operations while I2C slave can only do read operations done by the APB slave to the shared FIFO from which I2C slave gets the data.
<h2>Verification Architecture</h2>
<img src="https://github.com/AlPrime2k1/UVM/blob/main/APB%20-%20I2C%20Bridge/TB%20Architecture.png">
<h2>Directory Structure</h2>
<ul><li>ENV<ul><li>APB</li><li>I2C</li></ul>
<li>RTL</li>
<li>SIM</li>
<li>TEST : Contains individual folders for each testcase</li>
<li>TOP</li>
</ul><br>
<h2>How to use</h2>
<ol>
  <li>Download the file package</li>
  <li>Open the SIM folder and type cmd in the address bar. Alternatively open cmd and go inside the SIM folder of this directory</li>
  <li>In cmd, type "vlib work" to create working directory for Questa (Only needed for the first time)</li>
  <li>Type "make cli" to run regression </li>
  <li>Coverage report thus generated can be found in MERGED_REPORT folder inside the SIM directory in a file named as <b>index.html</b></li>
  <li>Assertion file can be found inside ENV directory </li>
</ol>
<h2>Future scope</h2>
<ul>
  <li>Debug the error injection testcase so that wrong value is driven in comparison to a reference value. 
    Presently correct value is driven to DUT but error is injected after monitoring which also gives error in the error injection testcase and in the coverage report.</li>
  <li>Add more comments to improve understanding of code.</li>
  <li>Add more assertions.</li>
  <li>Try to optimize the RTL and clean the code.</li>
  <li>Remove the redundant lines of code.</li>
</ul>
 
