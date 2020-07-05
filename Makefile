_MAJOR  := 1
_MINOR  := 2
_PATCH  := 0

include $(DEVKITARM)/base_rules


all:	thumb \
	gp2x_crt0.o thumb/gp2x_crt0.o \
	gp2x_940_crt0.o thumb/gp2x_940_crt0.o \


install: all
	@mkdir -p $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib
	@cp -v *.specs *.ld $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib
	@cp -rv *.o $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib
	@cp -v gp2x_rules $(DESTDIR)/opt/devkitpro/devkitARM

clean:
	rm -fr *.o

thumb:
	@mkdir -p $@

thumb/%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -mthumb -c $< -o$@

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@

dist:
	@tar -cJf gp2x-core-$(_MAJOR).$(_MINOR).$(_PATCH).tar.xz *.specs *.ld *.s gp2x_rules Makefile
