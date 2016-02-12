#SBATCH -N 1
#SBATCH -n 5
module load gatk/3.5
set -o nounset   # Prevent unset variables from been used.
set -o errexit   # Exit if error occurs

## RNA-seq variant calling as described in GATK best practises https://www.broadinstitute.org/gatk/guide/article?id=3891
## Best practies scripted below where Last updated on 2015-12-07 11:08:30 in link above

## Usage test case: sbatch SNP_call.sh ref BAM_in

## Set variables
threads=5 
BAM_input=test.bam
VCF_temp=28496.vcf
reference=ref.fasta
VCF_out=test/.bam.vcf

## Test variables
#BAM_input=test.bam
#VCF_temp=1464.vcf
#reference=test.fasta
#VCF_out=.bam.vcf


## Do the variant calling on 2-pass recalibrated BAM.
## -recoverDanglingHeads is default in gatk 3.5, but was not in previos versions. Use 3.5! 

echo "Running commnds:"
echo
echo gatk -T HaplotypeCaller 	-R  	-I  	-dontUseSoftClippedBases 	-stand_call_conf 20.0 	-stand_emit_conf 20.0 	--num_cpu_threads_per_data_thread  	-o 

## Do RNA-seq specific filtering
echo gatk -T VariantFiltration 	-R  	-V  	-window 35 -cluster 3 	-filterName FS -filter "FS > 30.0" 	-filterName QD -filter "QD < 2.0" 	-o 

gatk -T HaplotypeCaller 	-R  	-I  	-dontUseSoftClippedBases 	-stand_call_conf 20.0 	-stand_emit_conf 20.0 	--num_cpu_threads_per_data_thread  	-o 

## Do RNA-seq specific filtering
gatk -T VariantFiltration 	-R  	-V  	-window 35 -cluster 3 	-filterName FS -filter "FS > 30.0" 	-filterName QD -filter "QD < 2.0" 	-o 

