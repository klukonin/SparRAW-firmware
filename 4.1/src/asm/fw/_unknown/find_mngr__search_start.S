/* find_mngr__search_start @ 0x8e0030, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Search for %d msec.
 *   FIND:: Start SEARCHING on channel %d for %d msec.
 * Зовут его: find_mng__search
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1, lmac_if_discovery_mode_cfg_handler, u_schd__schedule
 */
	.section .text.find_mngr__search_start,"ax",@progbits
	.global find_mngr__search_start
find_mngr__search_start:
	.global L_8e0030
L_8e0030:
	push_s blink
L_8e0032:
	bl L_8c02c4
L_8e0036:
	mov_s r14,r0
L_8e0038:
	mov_s r13,r1
L_8e003a:
	mov_s r0,0x1
L_8e003c:
	bl.d L_8d84a8
L_8e0040:
	mov_s r1,r0
L_8e0042:
	add r0,r14,0x1c
L_8e0046:
	mov_s r1,0x1
L_8e0048:
	mov_s r2,0x0
L_8e004a:
	mov_s r3,r2
L_8e004c:
	bl.d L_8d6a1c
L_8e0050:
	mov_s r4,r2
L_8e0052:
	mov_s r2,0x1013f74
L_8e0058:
	mov_s r0,0xc
L_8e005a:
	mov_s r1,0x2
L_8e005c:
	bl.d L_8edfcc
L_8e0060:
	mov_s r3,r13
L_8e0062:
	breq_s r13,0,L_8e0092
L_8e0064:
	mul64 r13,0x3e8
L_8e0068:
	mov_s r2,0x0
L_8e006a:
	mov_s r0,0x200ec
L_8e0070:
	mov_s r1,r14
L_8e0072:
	mov r4,mlo
L_8e0076:
	mov_s r3,r2
L_8e0078:
	mov_s r5,r2
L_8e007a:
	bl.d L_8dc92c
L_8e007e:
	mov_s r6,r2
L_8e0080:
	st_s r0,[r14,0x18]
L_8e0082:
	mov_s r2,0x1013f90
L_8e0088:
	mov_s r0,0xc
L_8e008a:
	mov_s r1,0x2
L_8e008c:
	bl.d L_8edfcc
L_8e0090:
	mov_s r3,r13
	.global L_8e0092
L_8e0092:
	b L_8c0334
L_8e0096:
	nop_s
