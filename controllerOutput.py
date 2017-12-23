import pygame
# pygame.init()
pygame.joystick.init()

print "pygame.joystick.get_count()"
print pygame.joystick.get_count()

size = [50, 50]
screen = pygame.display.set_mode(size)

pygame.display.set_caption("End Effector Placement")

#Loop until the user clicks the close button.
done = False

clock = pygame.time.Clock()
