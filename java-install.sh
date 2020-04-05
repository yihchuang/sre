#!/bin/sh

sudo apt-get update -y
sudo apt install default-jre -y
sudo apt install openjdk-11-jre-headless -y
sudo apt install openjdk-8-jre-headless -y
sudo apt install unzip -y
dirpath=$(pwd)
wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.2.1.tgz
tar xf apache-jmeter-5.2.1.tgz
# wget https://perfrun67.blob.core.windows.net/testrun/microsoft-performance-0.0.1-SNAPSHOT-jar-with-dependencies.jar
# java -Dcsv.home=input.csv -jar microsoft-performance-0.0.1-SNAPSHOT-jar-with-dependencies.jar
cd apache-jmeter-5.2.1
wget https://jmeter-plugins.org/files/packages/jpgc-cmd-2.2.zip
wget https://jmeter-plugins.org/files/packages/jpgc-synthesis-2.2.zip
wget https://jmeter-plugins.org/files/packages/jpgc-filterresults-2.2.zip
wget https://jmeter-plugins.org/files/packages/jpgc-mergeresults-2.1.zip
unzip -o jpgc-cmd-2.2.zip
unzip -o jpgc-synthesis-2.2.zip
unzip -o jpgc-filterresults-2.2.zip
unzip -o jpgc-mergeresults-2.1.zip
cd bin 
binpath=$(pwd)
cd $dirpath
mkdir output
jmeterpath="${binpath}/jmeter.sh"
pluginpath="${binpath}/JMeterPluginsCMD.sh"
mergepluginpath="${binpath}/PluginsManagerCMD.sh"
jmxpath="${dirpath}/input.jmx"
outputpath="${dirpath}/output"
outputpathSummary="${outputpath}/Summary.csv"
outputpathAggregateReport="${outputpath}/AggregateReport.csv"
outputpathSynthesisReport="${outputpath}/SynthesisReport.csv"
outputpathThreadsStateOverTime="${outputpath}/ThreadsStateOverTime.csv"
outputpathBytesThroughputOverTime="${outputpath}/BytesThroughputOverTime.csv"
outputpathHitsPerSecond="${outputpath}/HitsPerSecond.csv"
outputpathLatenciesOverTime="${outputpath}/LatenciesOverTime.csv"
csvpath="${dirpath}/csv/output.csv"

echo $jmeterpath $pluginpath
bash $jmeterpath -n -t $jmxpath -l $outputpathSummary
bash $pluginpath --generate-csv $outputpathAggregateReport --input-jtl $outputpathSummary --plugin-type AggregateReport
bash $pluginpath --generate-csv $outputpathSynthesisReport --input-jtl $outputpathSummary --plugin-type SynthesisReport 
# bash $pluginpath --generate-csv $outputpathThreadsStateOverTime --input-jtl $outputpathSummary --plugin-type ThreadsStateOverTime 
# bash $pluginpath --generate-csv $outputpathBytesThroughputOverTime --input-jtl $outputpathSummary --plugin-type BytesThroughputOverTime 
# bash $pluginpath --generate-csv $outputpathHitsPerSecond --input-jtl $outputpathSummary --plugin-type HitsPerSecond 
# bash $pluginpath --generate-csv $outputpathLatenciesOverTime --input-jtl $outputpathSummary --plugin-type LatenciesOverTime 
# bash $mergepluginpath --tool Reporter --generate-csv merged.csv --input-jtl merge-results.properties --plugin-type MergeResults
# python -m SimpleHTTPServer 8080
