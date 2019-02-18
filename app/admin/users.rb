ActiveAdmin.register User do
actions :all ,except:[:update,:edit,:new]
end
