/* discovery__tsf_wa @ 0x8f1a9c, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::tsf_wa() WA Config  set_primary_channel = %d, ch = %d
 *   discovery::tsf_wa() WA Config done  ch = %d
 * Зовут его: find_mngr__cfg_offload, scan_mngr__start_scan
 * Зовёт сам: RADIO_MGR__set_primary_channel, RADIO_MGR__unset_primary_channel, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_log__emit2, get_g_800140_8c9f8c
 */
	.section .text.discovery__tsf_wa,"ax",@progbits
	.global discovery__tsf_wa
discovery__tsf_wa:
	.global L_8f1a9c
L_8f1a9c:
	push_s blink
L_8f1a9e:
	bl L_8c02c0
L_8f1aa2:
	sub_s sp,sp,0xc
L_8f1aa4:
	mov_s r14,r1
L_8f1aa6:
	mov_s r15,r2
L_8f1aa8:
	mov_s r13,sp
L_8f1aaa:
	bl.d L_8c9f8c
L_8f1aae:
	mov_s r0,r13
L_8f1ab0:
	ld r4,[sp]
L_8f1ab4:
	brne r4,0xffff,L_8f1ae4
L_8f1abc:
	mov_s r2,0x10126b4
L_8f1ac2:
	mov_s r0,0xc
L_8f1ac4:
	mov_s r1,0x2
L_8f1ac6:
	bl.d L_8edff8
L_8f1aca:
	mov_s r3,r14
L_8f1acc:
	ld_s r1,[sp,0x4]
L_8f1ace:
	mov_s r0,r14
L_8f1ad0:
	ld_s r2,[sp,0x8]
L_8f1ad2:
	mov_s r3,r15
L_8f1ad4:
	mov r4,0x1
L_8f1ad8:
	bl.d L_8e1ed8
L_8f1adc:
	mov r5,0x0
L_8f1ae0:
	bl L_8e5568
	.global L_8f1ae4
L_8f1ae4:
	bl.d L_8c9f8c
L_8f1ae8:
	mov_s r0,r13
L_8f1aea:
	mov_s r2,0x10126f8
L_8f1af0:
	mov_s r0,0xc
L_8f1af2:
	mov_s r1,0x2
L_8f1af4:
	bl.d L_8edfcc
L_8f1af8:
	ld_s r3,[sp,0x0]
L_8f1afa:
	b.d L_8c032c
L_8f1afe:
	add_s sp,sp,0xc
