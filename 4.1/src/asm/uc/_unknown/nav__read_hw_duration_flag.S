/* nav__read_hw_duration_flag @ 0x926b9c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: nav_db__update
 */
	.section .text.nav__read_hw_duration_flag,"ax",@progbits
	.global nav__read_hw_duration_flag
nav__read_hw_duration_flag:
	.global L_926b9c
L_926b9c:
	ld r2,[0x8812d8]
L_926ba4:
	mov r1,r0
L_926ba8:
	bbit0.d r2,0x4,L_926bb8
L_926bac:
	lsr r0,r2,0x4
L_926bb0:
	lsr_s r2,r2,0x10
L_926bb2:
	bmsk_s r2,r2,0x4
L_926bb4:
	st r2,[r1]
	.global L_926bb8
L_926bb8:
	j.d [blink]
L_926bbc:
	bmsk_s r0,r0,0x0
L_926bbe:
	nop_s
