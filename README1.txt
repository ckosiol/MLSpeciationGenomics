README 



###data_prepping using your terminal 

1. You need to clone the cflib git directory to use the FastaVCFToCounts.py
git clone https://github.com/pomo-dev/cflib.git

2. export PYTHONPATH=/Users/maeh1/pomo_balance/SimulationOutput/HLA-A\ /cflib:$PYTHONPATH  (change to YOUR PATH)

3. in order for the script to run you also need .gz and .gz.tbi files. make sure you compress them and index them before usinf the script 

-if you don't have bgzip
brew install htslib
- if you don't have tabix 
brew install tabix      

vcf_files=(HLA-A_1_p0.vcf HLA-A_1_p1.vcf HLA-A_1_p2.vcf)

bgzip "${vcf_files[@]}"

for f in "${vcf_files[@]/%/.gz}"; do
  tabix -p vcf "$f"
done


4. run script:  ./vcf_to_counts.sh
5. PLEASE ADUJST THE PATHS ACCORDING TO YOUR OWN DIRECTORIES 

 
