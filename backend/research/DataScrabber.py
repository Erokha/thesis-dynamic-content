from dataclasses import dataclass

@dataclass
class DataScrabber:
    filename: str

    def read_times(self):
        file = open(self.filename)
        size_array = []
        times_array = []
        for line in file.readlines():
            string = line.replace(' sec.', '').replace('\n', '').split(' - ')
            size_array.append(int(string[0]))
            times_array.append(float(string[1]))
        file.close()
        return [size_array, times_array]
