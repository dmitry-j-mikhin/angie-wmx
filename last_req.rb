#!/opt/wallarm/usr/bin/ruby_nocheck.sh

require 'tarantool16'
require 'proton-min'
require 'proton/serialized'
require 'proton/attacks'
require 'pp'

TDB = Tarantool16.new(host: '127.0.0.1:3313')

mapping_required = TDB.call('box.schema.func.exists', ['wallarm.select_requests'])[0][0]
r = TDB.call(mapping_required ? 'wallarm.select_requests' : 'box.space.requests:select', 
             [nil, {iterator: 'LE', limit: 1}]
            )[-1][1]
#File.write('/sr.msgpack', r)
sr = Proton::SerializedRequest.new(r)

sr.each { |entry| p [entry.point,
                     entry.value,
                     entry.value_len] }

#sr[[[:post], [:multipart, "data"], [:file]]]
#pp sr[[[:post],[:gzip]]].value_attack_type

#pp sr.attacks
pp sr.attacks(version: 1)
pp sr.attacks(version: 2)
pp sr.tags
#pp sr.probability
#pp sr.attack_type
#pp sr.attack_type(version: 2)
#pp sr.attack_type_global

#pp "---------"
#pp sr.to_json
#pp "--------"
#pp sr.attacks.to_json
