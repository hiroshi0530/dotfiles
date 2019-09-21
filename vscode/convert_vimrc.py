

def convert(arg):
  ret = ""
  
  for index, _str in enumerate(arg):
    if index == 0:
      ret = ret + '"after": ["{}", '.format(_str)
    elif index == len(arg) - 1:
      ret = ret + '"{}"]}},'.format(_str)
    else:
      ret = ret + '"{}", '.format(_str)
  
  print("")
  print(ret)
  print("")

strings = [
  "i<Right><Space><BlockMath>{`<CR>\\exp^{-\\lambda}\\frac{\\lambda^k}{k!}<CR><BS><BS>`}</BlockMath><Up>", 
  "i\\frac{}{}<Left><Left><Left>", 
  "i\\,\\,\\,\\,\\cdot\\cdot\\cdot\\cdot\\,\\,\\,\\,\\left(\\right)<Esc>b<Left>i<Esc>", 
]

if __name__ == "__main__":
  for arg in strings:
    convert(arg)
