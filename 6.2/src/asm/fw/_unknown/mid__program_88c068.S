/* mid__program_88c068 @ 0x8d0e14, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_sched_scheme
 * Глобалы (через gp): 0x800284, 0x800288, 0x80028c, 0x800290
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__program_88c068
mid__program_88c068:
	.global L_8d0e14
L_8d0e14:
	ldw_s r0,[gp,0x10c]
L_8d0e16:
	ldw.as r1,[gp,0x82]
L_8d0e1a:
	bmsk_s r0,r0,0xc
L_8d0e1c:
	asl_s r1,r1,0x10
L_8d0e1e:
	mov_s r2,0x1fff0000
L_8d0e24:
	and_s r1,r1,r2
L_8d0e26:
	or_s r1,r1,r0
L_8d0e28:
	bset_s r1,r1,0x1f
L_8d0e2a:
	mov_s r0,0x88c000
L_8d0e30:
	st_s r1,[r0,0x68]
L_8d0e32:
	ldw.as r1,[gp,0x84]
L_8d0e36:
	ldw.as r3,[gp,0x80]
L_8d0e3a:
	bmsk_s r1,r1,0xc
L_8d0e3c:
	asl_s r3,r3,0x10
L_8d0e3e:
	and_s r2,r2,r3
L_8d0e40:
	or_s r1,r1,r2
L_8d0e42:
	bset_s r1,r1,0x1f
L_8d0e44:
	st_s r1,[r0,0x6c]
L_8d0e46:
	j_s [blink]
