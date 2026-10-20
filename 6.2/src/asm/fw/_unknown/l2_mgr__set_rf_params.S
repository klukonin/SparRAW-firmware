/* l2_mgr__set_rf_params @ 0x8f9028, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::set_rf_params. cid=%d, num_of_rx_dmg_antennas=%d, total_number_of_sectors=%d
 * Зовут его: conn__set_rf_params_from_caps
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit3, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__set_rf_params
l2_mgr__set_rf_params:
	.global L_8f9028
L_8f9028:
	push_s blink
L_8f902a:
	bl L_8c01e0
L_8f902e:
	mov_s r14,r0
L_8f9030:
	mov_s r13,r1
L_8f9032:
	mov_s r15,r2
L_8f9034:
	mov_s r1,0x100eecc
L_8f903a:
	mov_s r0,0x2b
L_8f903c:
	mov_s r2,r14
L_8f903e:
	mov_s r3,r13
L_8f9040:
	bl.d L_8dcd00
L_8f9044:
	mov_s r4,r15
L_8f9046:
	bl L_8c3284
L_8f904a:
	mov_s r1,0x8
L_8f904c:
	st_s r1,[r0,0x4]
L_8f904e:
	st_s r14,[r0]
L_8f9050:
	mov_s r1,0x4c
L_8f9052:
	st_s r1,[r0,0x8]
L_8f9054:
	mov_s r1,0x2
L_8f9056:
	st_s r1,[r0,0xc]
L_8f9058:
	add r1,r0,0x10
L_8f905c:
	stb_s r13,[r1]
L_8f905e:
	stb_s r15,[r1,0x1]
L_8f9060:
	mov_s r1,0x18
L_8f9062:
	mov_s r2,0x20
L_8f9064:
	bl.d L_8e5204
L_8f9068:
	mov_s r3,0x0
L_8f906a:
	b L_8c024c
L_8f906e:
	nop_s
