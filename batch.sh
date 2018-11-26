#!/bin/bash

if [ ! -f ~/apikey.sh ]; then
  echo "api key not found. Please specify your Nomisweb API key in ./apikey.sh, e.g.:"
  echo "export NOMIS_API_KEY=0x0123456789abcdef0123456789abcdef01234567"
  exit 1
fi
. ~/apikey.sh

#TODO check conda source activate default

# batch submission

regions="E06000001 E06000002 E06000003 E06000004 E06000005 E06000006 E06000007 E06000008 E06000009 E06000010 E06000011 E06000012 E06000013 E06000014 \
E06000015 E06000016 E06000017 E06000018 E06000019 E06000020 E06000021 E06000022 E06000023 E06000024 E06000025 E06000026 E06000027 E06000028 E06000029 \
E06000030 E06000031 E06000032 E06000033 E06000034 E06000035 E06000036 E06000037 E06000038 E06000039 E06000040 E06000041 E06000042 E06000043 E06000044 \
E06000045 E06000046 E06000047 E06000049 E06000050 E06000051 E06000052 E06000053 E06000054 E06000055 E06000056 E06000057 E07000004 E07000005 E07000006 \
E07000007 E07000008 E07000009 E07000010 E07000011 E07000012 E07000026 E07000027 E07000028 E07000029 E07000030 E07000031 E07000032 E07000033 E07000034 \
E07000035 E07000036 E07000037 E07000038 E07000039 E07000040 E07000041 E07000042 E07000043 E07000044 E07000045 E07000046 E07000047 E07000048 E07000049 \
E07000050 E07000051 E07000052 E07000053 E07000061 E07000062 E07000063 E07000064 E07000065 E07000066 E07000067 E07000068 E07000069 E07000070 E07000071 \
E07000072 E07000073 E07000074 E07000075 E07000076 E07000077 E07000078 E07000079 E07000080 E07000081 E07000082 E07000083 E07000084 E07000085 E07000086 \
E07000087 E07000088 E07000089 E07000090 E07000091 E07000092 E07000093 E07000094 E07000095 E07000096 E07000098 E07000099 E07000102 E07000103 E07000105 \
E07000106 E07000107 E07000108 E07000109 E07000110 E07000111 E07000112 E07000113 E07000114 E07000115 E07000116 E07000117 E07000118 E07000119 E07000120 \
E07000121 E07000122 E07000123 E07000124 E07000125 E07000126 E07000127 E07000128 E07000129 E07000130 E07000131 E07000132 E07000133 E07000134 E07000135 \
E07000136 E07000137 E07000138 E07000139 E07000140 E07000141 E07000142 E07000143 E07000144 E07000145 E07000146 E07000147 E07000148 E07000149 E07000150 \
E07000151 E07000152 E07000153 E07000154 E07000155 E07000156 E07000163 E07000164 E07000165 E07000166 E07000167 E07000168 E07000169 E07000170 E07000171 \
E07000172 E07000173 E07000174 E07000175 E07000176 E07000177 E07000178 E07000179 E07000180 E07000181 E07000187 E07000188 E07000189 E07000190 E07000191 \
E07000192 E07000193 E07000194 E07000195 E07000196 E07000197 E07000198 E07000199 E07000200 E07000201 E07000202 E07000203 E07000204 E07000205 E07000206 \
E07000207 E07000208 E07000209 E07000210 E07000211 E07000212 E07000213 E07000214 E07000215 E07000216 E07000217 E07000218 E07000219 E07000220 E07000221 \
E07000222 E07000223 E07000224 E07000225 E07000226 E07000227 E07000228 E07000229 E07000234 E07000235 E07000236 E07000237 E07000238 E07000239 E07000240 \
E07000241 E07000242 E07000243 E08000001 E08000002 E08000003 E08000004 E08000005 E08000006 E08000007 E08000008 E08000009 E08000010 E08000011 E08000012 \
E08000013 E08000014 E08000015 E08000016 E08000017 E08000018 E08000019 E08000021 E08000022 E08000023 E08000024 E08000025 E08000026 E08000027 E08000028 \
E08000029 E08000030 E08000031 E08000032 E08000033 E08000034 E08000035 E08000036 E08000037 E09000001 E09000002 E09000003 E09000004 E09000005 E09000006 \
E09000007 E09000008 E09000009 E09000010 E09000011 E09000012 E09000013 E09000014 E09000015 E09000016 E09000017 E09000018 E09000019 E09000020 E09000021 \
E09000022 E09000023 E09000024 E09000025 E09000026 E09000027 E09000028 E09000029 E09000030 E09000031 E09000032 E09000033 \
W06000001 W06000002 W06000003 W06000004 W06000005 W06000006 W06000008 W06000009 W06000010 W06000011 W06000012 W06000013 W06000014 W06000015 W06000016 \ W06000018 W06000019 W06000020 W06000021 W06000022 W06000023 W06000024 \
S12000033 S12000034 S12000041 S12000035 S12000036 S12000005 S12000006 S12000042 S12000008 S12000045 S12000010 S12000011 S12000014 S12000015 S12000046 \ S12000017 S12000018 S12000019 S12000020 S12000013 S12000021 S12000044 S12000023 S12000024 S12000038 S12000026 S12000027 S12000028 S12000029 S12000030 \
S12000039 S12000040"

# max run time (NB Birmingham takes longest at ~?h)
qsub_params="-l h_rt=8:0:0"

for region in $regions; do
  export REGION=$region
  echo Submitting job for $REGION
  qsub -o ./logs -e ./logs $qsub_params run.sh
  sleep 1
done

