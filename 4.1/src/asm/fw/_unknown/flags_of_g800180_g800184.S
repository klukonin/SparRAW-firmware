/* flags_of_g800180_g800184 @ 0x8ebd7c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rw_g_8043d4
 * Глобалы (через gp): 0x800180, 0x800184
 */
	.section .text.flags_of_g800180_g800184,"ax",@progbits
	.global flags_of_g800180_g800184
flags_of_g800180_g800184:
	.global L_8ebd7c
L_8ebd7c:
	ldb_s r0,[r0]
L_8ebd7e:
	mov_s r1,0x0
L_8ebd80:
	cmp_s r0,0x0
L_8ebd82:
	jeq.d [blink]
L_8ebd86:
	mov.eq r0,r1
L_8ebd8a:
	ld_s r0,[gp,0x10]
L_8ebd8c:
	ld.as r1,[gp,0x5]
L_8ebd90:
	cmp_s r0,0x0
L_8ebd92:
	mov.ne r0,0x1
L_8ebd96:
	cmp_s r1,0x0
L_8ebd98:
	jne.d [blink]
L_8ebd9c:
	bset.ne r0,r0,0x1
L_8ebda0:
	j_s [blink]
L_8ebda2:
	nop_s
