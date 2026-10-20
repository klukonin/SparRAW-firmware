/* remove_app_ie @ 0x8de250, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   remove_app_ie: frame type %x length %d. IE type: %d
 *   mid.cpp
 * Зовут его: ese_cfg__apply
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, app_ie__remove_tlv, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.remove_app_ie,"ax",@progbits
	.global remove_app_ie
remove_app_ie:
	.global L_8de250
L_8de250:
	b.d L_8de258
L_8de254:
	add_s r0,r0,0x48
L_8de256:
	nop_s
	.global L_8de258
L_8de258:
	push_s blink
L_8de25a:
	bl L_8c02b8
L_8de25e:
	mov_s r16,r0
L_8de260:
	mov_s r14,r1
L_8de262:
	mov_s r17,r2
L_8de264:
	mov_s r2,0x100b3b4
L_8de26a:
	mov_s r0,0xb
L_8de26c:
	mov_s r1,0x2
L_8de26e:
	mov_s r3,r14
L_8de270:
	bl.d L_8edff8
L_8de274:
	mov r4,r17
L_8de278:
	brhs.d r14,0x5,L_8de2b0
L_8de27c:
	mov_s r13,0x0
L_8de27e:
	ldb.x r14,[0x801e84,r14]
L_8de286:
	add r0,pcl,0xa
L_8de28a:
	add1_s r0,r0,r14
L_8de28c:
	j_s [r0]
L_8de28e:
	add3 r0,r16,0x3c
L_8de292:
	b_s L_8de2c8
L_8de294:
	add3 r0,r16,0x36
L_8de298:
	b_s L_8de2c8
L_8de29a:
	mov_s r0,r16
L_8de29c:
	add r0,r0,0x1bc
L_8de2a0:
	b_s L_8de2c8
L_8de2a2:
	add3 r0,r16,0x39
L_8de2a6:
	b_s L_8de2c8
L_8de2a8:
	mov_s r0,r16
L_8de2aa:
	add r0,r0,0x1d4
L_8de2ae:
	b_s L_8de2c8
	.global L_8de2b0
L_8de2b0:
	mov_s r0,blink
L_8de2b2:
	mov_s r2,0x100aedc
L_8de2b8:
	mov_s r1,0x11f4
L_8de2be:
	bl.d L_8c82c0
L_8de2c2:
	mov r3,0x76c
L_8de2c6:
	mov_s r0,r13
	.global L_8de2c8
L_8de2c8:
	bl.d L_8de1a4
L_8de2cc:
	mov_s r1,r17
L_8de2ce:
	b L_8c031c
L_8de2d2:
	nop_s
