

def test():
  test = ["abc<Space>11efg<ESC>987ooo"]

  targets = ["<Space>", "<ESC>"]
  

  b = []
  for a in test:
    print(a)
    a.split("")

  # b = []
  # for index, target in enumerate(targets):
  #   if index == 0:
  #     a = test.split(target)
  #   
  #   for index1, arg in enumerate(a):
  #     if index1 != len(a) - 1:
  #       b.append(arg)
  #       b.append(target) 
  #     else:
  #       b.append(arg)

  #   if index != len(targets) - 1:
  #     a = ''.join(b)
  #     print(a)
  #     print("AAAAAAAA")

  # print(b)


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
  test()
  # for arg in strings:
  #   convert(arg)
