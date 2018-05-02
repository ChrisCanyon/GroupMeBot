class CreateBots < ActiveRecord::Migration[5.1]
  def change
    create_table :bots do |t|
      t.string :bot_id
      t.string :active_commands, array: true, default: [:add_library, :remove_library, :refresh_libraries, :libraries, :active_libraries, :commands, :request_feature]
      t.string :active_libraries, array: true, default: []
      t.integer :group_id

      t.timestamps
    end
  end
end

["458203,1214,17314106",
 "223905,82,2422093",
 "186782,83,2843351",
 "367770,82,2486774",
 "331597,84,3092093",
 "473591,76,1411920",
 "239038,70,746505",
 "415641,76,1403987",
 "364541,70,763068",
 "742591,56,190086",
 "986400,23,6984",
 "741604,53,139923",
 "432539,54,157315",
 "470982,56,189774",
 "673363,43,51819",
 "664166,50,103353",
 "671513,25,8178",
 "404882,58,232429",
 "318193,53,150358",
 "287402,72,899757",
 "459215,29,12338",
 "771616,9,1001",
 "757330,9,1000",
 "-1,1,0",
 "-1,-1",
 "-1,-1",
 "-1,-1",
 "-1,-1",
 "-1,-1",
 "-1,-1",
 "92548,500",
 "-1,-1",
 "-1,-1"]
