/* hwd_rfc_powerdown_deep_all_rfs @ 0x929fa0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_powerdown_deep_all_rfs
 *   hwd_RFC_POWERDOWN_DEEP_ENTRY
 *   hwd_rfc_powerdown_deep_all_rfs - orig_rfc:%d
 * Зовут его: hw__power_sequence_rf
 * Зовёт сам: hwd_rfc_write_core, rfca__select_rf_uc, uc_log__emit1, uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_powerdown_deep_all_rfs
hwd_rfc_powerdown_deep_all_rfs:
	.global L_929fa0
L_929fa0:
	push_s blink
L_929fa2:
	sub_s sp,sp,0x4
L_929fa4:
	mov r1,0x10020bc
L_929fac:
	bl.d L_92d13c
L_929fb0:
	mov r0,0x29
L_929fb4:
	mov r1,sp
L_929fb8:
	bl.d L_928b8c
L_929fbc:
	mov r0,0xff
L_929fc0:
	mov_s r0,0x0
L_929fc2:
	mov_s r1,0x6
L_929fc4:
	mov r2,0x1
L_929fc8:
	bl.d L_92a3d8
L_929fcc:
	mov r3,r0
L_929fd0:
	mov_s r0,0x0
L_929fd2:
	mov_s r1,0x8
L_929fd4:
	mov r2,r0
L_929fd8:
	bl.d L_92a3d8
L_929fdc:
	mov r3,r0
L_929fe0:
	mov r1,0x100209c
L_929fe8:
	bl.d L_92d13c
L_929fec:
	mov r0,0x29
L_929ff0:
	ldb r0,[sp]
L_929ff4:
	bl.d L_928b8c
L_929ff8:
	mov r1,0x0
L_929ffc:
	mov_s r1,0x10020dc
L_92a002:
	mov_s r0,0x29
L_92a004:
	bl.d L_92d1d0
L_92a008:
	ldb r2,[sp]
L_92a00c:
	add_s sp,sp,0x4
L_92a00e:
	pop_s blink
L_92a010:
	j_s [blink]
L_92a012:
	nop_s
