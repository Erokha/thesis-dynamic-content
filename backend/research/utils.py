from DataScrabber import DataScrabber
from Plotter import *
import math
import numpy as np

domain_times = DataScrabber("/Users/erokha/thesis-dynamic-content/backend/research/domain_times.txt").read_times()
dto_time = DataScrabber("/Users/erokha/thesis-dynamic-content/backend/research/dto_time.txt").read_times()

# domain_plot_info = PlotInfo(x=domain_times[0], y=domain_times[1], title="Конфигурация из структур прикладного уровня")
# dto_plot_info = PlotInfo(x=dto_time[0], y=dto_time[1], title="Конфигурация из структур траспортного уровня")
#
# line_one = PlotInfo(x = [1, 2, 3], y= [1, 4, 9], title="Квадрат")
#
# Plotter([dto_plot_info, domain_plot_info]).draw(should_save_to_pdf=True)

data = dto_time
data[1] = [i * 28303616 for i in data[1]]
array = [math.log(time, size) for (size, time) in zip(data[0][1:], data[1][1:])]
print(np.mean(array))

