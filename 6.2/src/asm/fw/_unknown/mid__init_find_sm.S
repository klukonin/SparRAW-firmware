/* mid__init_find_sm @ 0x8d9588, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_scan_and_pools
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mid_list__by_mid_fw, obj_vt8030f4__ctor
 * Глобалы (через gp): 0x800240
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__init_find_sm
mid__init_find_sm:
	.global L_8d9588
L_8d9588:
	push_s blink
L_8d958a:
	bl L_8c01e4
L_8d958e:
	mov_s r13,r0
L_8d9590:
	add_s r0,r0,0x1c
L_8d9592:
	bl.d L_8f532c
L_8d9596:
	mov_s r1,r13
L_8d9598:
	mov_s r14,0x0
L_8d959a:
	bl.d L_8cc3dc
L_8d959e:
	mov_s r0,r14
L_8d95a0:
	st_s r0,[r13,0x48]
L_8d95a2:
	mov_s r0,0x1
L_8d95a4:
	st_s r0,[r13,0xc]
L_8d95a6:
	ldb_s r0,[gp,0xbc]
L_8d95a8:
	st_s r14,[r13,0x40]
L_8d95aa:
	stb_s r0,[r13,0x10]
L_8d95ac:
	st_s r14,[r13,0x18]
L_8d95ae:
	b.d L_8c0254
L_8d95b2:
	st_s r14,[r13,0x44]
