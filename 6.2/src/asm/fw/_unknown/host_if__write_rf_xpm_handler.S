/* host_if__write_rf_xpm_handler @ 0x8e36cc, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   host_if::write_rf_xpm_handler(): XPM write failed. rf_id=%d, xpm_bit_address=0x%x, num_bytes=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit3, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_read_block, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__write_rf_xpm_handler
host_if__write_rf_xpm_handler:
	.global L_8e36cc
L_8e36cc:
	push_s blink
L_8e36ce:
	bl L_8c01d8
L_8e36d2:
	sub_s sp,sp,0x4
L_8e36d4:
	mov_s r16,r0
L_8e36d6:
	bl.d L_8c33d0
L_8e36da:
	mov_s r13,r1
L_8e36dc:
	mov_s r14,r0
L_8e36de:
	ld r0,[r16, 0x70]
L_8e36e2:
	add r15,r13,0x10
L_8e36e6:
	sub r4,r0,0x10
L_8e36ea:
	ldb_s r0,[r13]
L_8e36ec:
	mov_s r3,r15
L_8e36ee:
	ld_s r1,[r13,0x4]
L_8e36f0:
	mov r17,0x0
L_8e36f4:
	ld_s r2,[r13,0x8]
L_8e36f6:
	bl.d L_8f46f4
L_8e36fa:
	mov r5,r17
L_8e36fe:
	mov_s r1,0x1
L_8e3700:
	stb_s r1,[r14]
L_8e3702:
	brne r0,0x1,L_8e3726
L_8e3706:
	ldb r6,[r13, 0xc]
L_8e370a:
	mov_s r3,r15
L_8e370c:
	ldb_s r0,[r13]
L_8e370e:
	mov r4,r17
L_8e3712:
	ld_s r1,[r13,0x4]
L_8e3714:
	ld_s r2,[r13,0x8]
L_8e3716:
	bl.d L_8f4a30
L_8e371a:
	mov r5,0x12
L_8e371e:
	brne r0,0x1,L_8e3726
L_8e3722:
	stb r17,[r14]
	.global L_8e3726
L_8e3726:
	ldb_s r0,[r14]
L_8e3728:
	breq_s r0,0,L_8e373e
L_8e372a:
	ld r4,[r13, 0x8]
L_8e372e:
	mov_s r1,0x1006194
L_8e3734:
	ldb_s r2,[r13]
L_8e3736:
	mov_s r0,0x0
L_8e3738:
	bl.d L_8dcd00
L_8e373c:
	ld_s r3,[r13,0x4]
	.global L_8e373e
L_8e373e:
	st r17,[sp]
L_8e3742:
	mov_s r0,r16
L_8e3744:
	mov_s r1,r14
L_8e3746:
	mov_s r2,0x0
L_8e3748:
	mov_s r3,0x1857
L_8e374e:
	mov r4,0x1
L_8e3752:
	mov_s r5,r2
L_8e3754:
	mov_s r6,r2
L_8e3756:
	bl.d L_8e4fc4
L_8e375a:
	mov_s r7,r2
L_8e375c:
	ldb_s r0,[r14]
L_8e375e:
	b.d L_8c023c
L_8e3762:
	add_s sp,sp,0x4
