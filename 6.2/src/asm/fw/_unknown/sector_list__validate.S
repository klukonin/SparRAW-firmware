/* sector_list__validate @ 0x8d9ac8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   first sector in array is 0xFF
 *   sectore id > MAX_NUM_OF_SECTORS(%d), sector =%d , index =%d
 * Зовут его: bcn_tx_init_ss_params, lmac_if_config_txss, lmac_if_set_ss_sectors_default_cfg_handler, lmac_if_set_ss_sectors_order_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit3, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sector_list__validate
sector_list__validate:
	.global L_8d9ac8
L_8d9ac8:
	push_s blink
L_8d9aca:
	bl L_8c01d4
L_8d9ace:
	mov_s r15,r0
L_8d9ad0:
	mov_s r14,r1
L_8d9ad2:
	mov_s r17,r2
L_8d9ad4:
	ldb_s r1,[r1]
L_8d9ad6:
	mov_s r0,0xff
L_8d9ad8:
	mov_s r16,r3
L_8d9ada:
	mov r18,0x0
L_8d9ade:
	brne r1,r0,L_8d9afe
L_8d9ae2:
	mov_s r1,0x1003ad8
L_8d9ae8:
	bl.d L_8dcba8
L_8d9aec:
	mov_s r0,r18
L_8d9aee:
	mov_s r13,r18
L_8d9af0:
	b_s L_8d9b3e
	.global L_8d9af2
L_8d9af2:
	cmp_s r3,0x40
L_8d9af4:
	bge_s L_8d9b10
L_8d9af6:
	add r18,r18,0x1
L_8d9afa:
	extb r18,r18
	.global L_8d9afe
L_8d9afe:
	cmp r18,0x40
L_8d9b02:
	bge_s L_8d9b0c
L_8d9b04:
	ldb r3,[r14,r18]
L_8d9b08:
	brne r3,r0,L_8d9af2
	.global L_8d9b0c
L_8d9b0c:
	mov_s r13,0x1
L_8d9b0e:
	b_s L_8d9b24
	.global L_8d9b10
L_8d9b10:
	mov_s r1,0x1003af8
L_8d9b16:
	mov_s r13,0x0
L_8d9b18:
	mov_s r0,r13
L_8d9b1a:
	mov_s r2,0x40
L_8d9b1c:
	bl.d L_8dcd00
L_8d9b20:
	mov r4,r18
	.global L_8d9b24
L_8d9b24:
	breq_s r13,0,L_8d9b3e
L_8d9b26:
	add r0,r15,0x8
L_8d9b2a:
	mov_s r1,r14
L_8d9b2c:
	bl.d L_8c0380
L_8d9b30:
	mov_s r2,0x40
L_8d9b32:
	stb r18,[r15, 0x48]
L_8d9b36:
	st r17,[r15]
L_8d9b3a:
	st r16,[r15, 0x4]
	.global L_8d9b3e
L_8d9b3e:
	b.d L_8c0234
L_8d9b42:
	mov_s r0,r13
