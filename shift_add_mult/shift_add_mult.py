import math
import matplotlib
import matplotlib.pyplot as plt

matplotlib.use('wxAgg')

# 0
# ans = 0
# 15
# ans = p/8
# 47
# ans = p/4
# 79
# 111
# 143
# 175
# 207
# 239
# 255
def mult(beta, potential):
    return int((beta/255)*potential)

def shift_add_mult(beta, potential):
    potential_2 = int(potential/2)
    potential_4 = int(potential/4)
    potential_8 = int(potential/8)
    
    if ( 15 > beta >= 0 ):
        return 0
    
    elif (47 > beta >= 15):
        return potential_8
    
    elif (79 > beta >= 47):
        return potential_4
    
    elif (111 > beta >= 79):
        return potential_4 + potential_8
    
    elif (143 > beta >= 111):
        return potential_2
    
    elif (175 > beta >= 143):
        return potential_2 + potential_8
    
    elif (207 > beta >= 175):
        return potential_2 + potential_4
    
    elif (239 > beta >= 207):
        return potential_2 + potential_4 + potential_8
    
    elif (255 >= beta >= 239):
        return potential
    
error = []
for i in range(256):
    for j in range(256):
        error_i_j = shift_add_mult(i,j) - mult(i,j)
        error.append(error_i_j)
print("Maximum error of the method:")
print(max(error))

U = 122
beta = []
ans = []
for i in range(256):
    beta.append(i)
    ans.append(shift_add_mult(i,U))
    
fig, ax = plt.subplots()
ax.plot(beta, ans)
ax.grid()
ax.set(xlabel='beta', ylabel='shift-add multiplication',
       title='shift-add multiplication for U=122')
fig.savefig("test.png")
plt.show()
# print(shift_add_mult(187, 153))

# for i in range(20):
#     if ((i*1/16)%(1/8)):
#         print(int((i*1/16)*255))

