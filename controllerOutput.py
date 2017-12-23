import pygame
pygame.init()
print "pygame.joystick.get_count()"
print pygame.joystick.get_count()

size = [50, 50]
screen = pygame.display.set_mode(size)

pygame.display.set_caption("End Effector Placement")
