/* stream_mgr__add_bcast_vring @ 0x8c2138, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: wmi_handler_bcast_vring_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_dma__macq_reg_addr, l2mgr__send_vring_cfg_done, vring_schd__add_vring, vring_schd__alloc_pring
 */
	.section .text.stream_mgr__add_bcast_vring,"ax",@progbits
	.global stream_mgr__add_bcast_vring
stream_mgr__add_bcast_vring:
	.global L_8c2138
L_8c2138:
	push_s blink
L_8c213a:
	bl L_8c02bc
L_8c213e:
	mov_s r13,r0
L_8c2140:
	ldb_s r14,[r0,0x7]
L_8c2142:
	mov_s r15,0x8485dc
L_8c2148:
	add2_s r15,r15,r14
L_8c214a:
	ld_s r0,[r15,0x18]
L_8c214c:
	mov_s r16,r1
L_8c214e:
	brne_s r0,0,L_8c217a
	.global L_8c2150
L_8c2150:
	st_s r13,[r15,0x18]
L_8c2152:
	mov_s r0,r16
L_8c2154:
	mov_s r1,r13
L_8c2156:
	mov_s r2,0x0
L_8c2158:
	bl.d L_8c276c
L_8c215c:
	mov_s r3,r2
L_8c215e:
	bl.d L_8c1dac
L_8c2162:
	mov_s r0,r14
L_8c2164:
	bl.d L_8cda90
L_8c2168:
	mov_s r0,r14
L_8c216a:
	mov_s r1,r0
L_8c216c:
	mov_s r0,r14
L_8c216e:
	mov_s r2,0x0
L_8c2170:
	bl.d L_8f0b8c
L_8c2174:
	ld_s r3,[r13,0x8]
L_8c2176:
	b L_8c0324
	.global L_8c217a
L_8c217a:
	mov_s r0,blink
L_8c217c:
	mov_s r2,0x100e398
L_8c2182:
	mov_s r1,0x1287
L_8c2188:
	bl.d L_8c82c0
L_8c218c:
	mov_s r3,0x8b
L_8c218e:
	b_s L_8c2150
